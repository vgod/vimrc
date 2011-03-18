#!/usr/bin/python

# Part of Latex-Suite
#
# Copyright: Srinath Avadhanula
# Description:
#   This file implements a simple outline creation for latex documents.

import re
import os
import sys
import StringIO

# getFileContents {{{
def getFileContents(fname):
    if type(fname) is not str:
        fname = fname.group(3)

    # If neither the file or file.tex exists, then we just give up.
    if not os.path.isfile(fname):
        if os.path.isfile(fname + '.tex'):
            fname += '.tex'
        else:
            return ''

    try:
        # This longish thing is to make sure that all files are converted into
        # \n seperated lines.
        contents = '\n'.join(open(fname).read().splitlines())
    except IOError:
        return ''

    # TODO what are all the ways in which a tex file can include another?
    pat = re.compile(r'^\\(@?)(include|input){(.*?)}', re.M)
    contents = re.sub(pat, getFileContents, contents)

    return ('%%==== FILENAME: %s' % fname) + '\n' + contents

# }}}
# stripComments {{{
def stripComments(contents):
    # remove all comments except those of the form
    # %%==== FILENAME: <filename.tex>
    # BUG: This comment right after a new paragraph is not recognized: foo\\%comment
    uncomm = [re.sub('(?<!\\\\)%(?!==== FILENAME: ).*', '', line) for line in contents.splitlines()]
    # also remove all only-whitespace lines.
    nonempty = [line for line in uncomm if line.strip()]

    return nonempty
# }}}
# addFileNameAndNumber {{{
def addFileNameAndNumber(lines):
    filename = ''
    retval = ''
    for line in lines:
        if re.match('%==== FILENAME: ', line):
            filename = line.split('%==== FILENAME: ')[1]
        else:
            retval += '<%s>%s\n' % (filename, line)

    return retval
# }}}
# getSectionLabels_Root {{{
def getSectionLabels_Root(lineinfo, section_prefix, label_prefix):
    prev_txt = ''
    inside_env = 0
    prev_env = ''
    outstr = StringIO.StringIO('')
    pres_depth = len(section_prefix)

    #print '+getSectionLabels_Root: lineinfo = [%s]' % lineinfo
    for line in lineinfo.splitlines():
        if not line:
            continue

        # throw away leading white-space
        m = re.search('<(.*?)>(.*)', line)

        fname = m.group(1)
        line = m.group(2).lstrip()

        # we found a label!
        m = re.search(r'\\label{(%s.*?)}' % label_prefix, line)
        if m:
            # add the current line (except the \label command) to the text
            # which will be displayed below this label
            prev_txt += re.search(r'(^.*?)\\label{', line).group(1)

            # for the figure environment however, just display the caption.
            # instead of everything since the \begin command.
            if prev_env == 'figure':
                cm = re.search(r'\caption(\[.*?\]\s*)?{(.*?)}', prev_txt)
                if cm:
                    prev_txt = cm.group(2)

            # print a nice formatted text entry like so
            #
            # >        eqn:label
            # :          e^{i\pi} + 1 = 0
            #
            # Use the current "section depth" for the leading indentation.
            print >>outstr, '>%s%s\t\t<%s>' % (' '*(2*pres_depth+2),
                    m.group(1), fname)
            print >>outstr, ':%s%s' % (' '*(2*pres_depth+4), prev_txt)
            prev_txt = ''

        # If we just encoutered the start or end of an environment or a
        # label, then do not remember this line. 
        # NOTE: This assumes that there is no equation text on the same
        # line as the \begin or \end command. The text on the same line as
        # the \label was already handled.
        if re.search(r'\\begin{(equation|eqnarray|align|figure)', line):
            prev_txt = ''
            prev_env = re.search(r'\\begin{(.*?)}', line).group(1)
            inside_env = 1

        elif re.search(r'\\label', line):
            prev_txt = ''

        elif re.search(r'\\end{(equation|eqnarray|align|figure)', line):
            inside_env = 0
            prev_env = ''

        else:
            # If we are inside an environment, then the text displayed with
            # the label is the complete text within the environment,
            # otherwise its just the previous line.
            if inside_env:
                prev_txt += line
            else:
                prev_txt = line

    return outstr.getvalue()
    
# }}}
# getSectionLabels {{{
def getSectionLabels(lineinfo, 
        sectypes=['chapter', 'section', 'subsection', 'subsubsection'], 
        section_prefix='', label_prefix=''):

    if not sectypes:
        return getSectionLabels_Root(lineinfo, section_prefix, label_prefix)

    ##print 'sectypes[0] = %s, section_prefix = [%s], lineinfo = [%s]' % (
    ##        sectypes[0], section_prefix, lineinfo)

    sections = re.split(r'(<.*?>\\%s{.*})' % sectypes[0], lineinfo)
    
    # there will 1+2n sections, the first containing the "preamble" and the
    # others containing the child sections as paris of [section_name,
    # section_text]

    rettext = getSectionLabels(sections[0], sectypes[1:], section_prefix, label_prefix)
 
    for i in range(1,len(sections),2):
        sec_num = (i+1)/2
        section_name = re.search(r'\\%s{(.*?)}' % sectypes[0], sections[i]).group(1)
        section_label_text = getSectionLabels(sections[i] + sections[i+1], sectypes[1:], 
                                    section_prefix+('%d.' % sec_num), label_prefix)

        if section_label_text:
            sec_heading = 2*' '*len(section_prefix) + section_prefix
            sec_heading += '%d. %s' % (sec_num, section_name)
            sec_heading += '<<<%d\n' % (len(section_prefix)/2+1)

            rettext += sec_heading + section_label_text

    return rettext
    
# }}}

# main {{{
def main(fname, label_prefix):
    [head, tail] = os.path.split(fname)
    if head:
        os.chdir(head)

    contents = getFileContents(fname)
    nonempty = stripComments(contents)
    lineinfo = addFileNameAndNumber(nonempty)

    return getSectionLabels(lineinfo, label_prefix=label_prefix)
# }}}

if __name__ == "__main__":
    if len(sys.argv) > 2:
        prefix = sys.argv[2]
    else:
        prefix = ''

    print main(sys.argv[1], prefix)


# vim: fdm=marker
