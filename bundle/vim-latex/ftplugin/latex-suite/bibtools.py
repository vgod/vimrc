# Author: Srinath Avadhanula
# This file is distributed as part of the vim-latex project
# http://vim-latex.sf.net

import re

class Bibliography(dict):
    def __init__(self, txt, macros={}):
        """
        txt:
            a string which represents the entire bibtex entry. A typical
            entry is of the form:
                @ARTICLE{ellington:84:part3,
                  author = {Ellington, C P},
                  title = {The Aerodynamics of Hovering Insect Flight. III. Kinematics},
                  journal = {Philosophical Transactions of the Royal Society of London. Series B, Biological Sciences},
                  year = {1984},
                  volume = {305},
                  pages = {41-78},
                  number = {1122},
                  owner = {Srinath},
                  pdf = {C:\srinath\research\papers\Ellington-3-Kinematics.pdf},
                  timestamp = {2006.01.02},
                }
        """
        
        if macros:
            for k, v in macros.iteritems():
                txt = txt.replace(k, '{'+v+'}')
        
        m = re.match(r'\s*@(\w+){((\S+),)?(.*)}\s*', txt, re.MULTILINE | re.DOTALL)
        if not m:
            return None

        self['bibtype'] = m.group(1).capitalize()
        self['key'] = m.group(3)
        self['body'] = m.group(4)

        body = self['body']
        self['bodytext'] = ''
        while 1:
            m = re.search(r'(\S+?)\s*=\s*(.)', body)
            if not m:
                break

            field = m.group(1)

            body = body[(m.start(2)+1):]
            if m.group(2) == '{':
                # search for the next closing brace. This is not simply a
                # matter of searching for the next closing brace since
                # braces can be nested. The following code basically goes
                # to the next } which has not already been closed by a
                # following {.
                mniter = re.finditer(r'{|}', body)

                count = 1
                while 1:
                    try:
                        mn = mniter.next()
                    except StopIteration:
                        return None

                    if mn.group(0) == '{':
                        count += 1
                    else:
                        count -= 1

                    if count == 0:
                        value = body[:(mn.start(0))]
                        break

            elif m.group(2) == '"':
                # search for the next unquoted double-quote. To be more
                # precise, a double quote which is preceded by an even
                # number of double quotes.
                mn = re.search(r'(?!\\)(\\\\)*"', body)
                if not mn:
                    return None

                value = body[:(mn.start(0))]

            else:
                # $ always matches. So we do not need to do any
                # error-checking.
                mn = re.search(r',|$', body)
                value = m.group(2) + body[:(mn.start(0))].rstrip()

            self[field.lower()] = re.sub(r'\s+', ' ', value)
            body = body[(mn.start(0)+1):]

            self['bodytext'] += ('  %s: %s\n' % (field, value))
            if self['bibtype'].lower() == 'string':
                self['macro'] = {field: value}

        self['bodytext'] = self['bodytext'].rstrip()
        

    def __getitem__(self, key):
        try:
            return dict.__getitem__(self, key)
        except KeyError:
            return ''
        
    def __str__(self):
        if self['bibtype'].lower() == 'string':
            return 'String: %(macro)s' % self

        elif self['bibtype'].lower() == 'article':
            return ('Article [%(key)s]\n' +
                    'TI "%(title)s"\n' +
                    'AU %(author)s\n' +
                    'IN In %(journal)s, %(year)s') % self

        elif self['bibtype'].lower() == 'conference':
            return ('Conference [%(key)s]\n' +
                    'TI "%(title)s"\n' +
                    'AU %(author)s\n' +
                    'IN In %(booktitle)s, %(year)s') % self

        elif self['bibtype'].lower() == 'mastersthesis':
            return ('Masters [%(key)s]\n' + 
                    'TI "%(title)s"\n' + 
                    'AU %(author)s\n' + 
                    'IN In %(school)s, %(year)s') % self

        elif self['bibtype'].lower() == 'phdthesis':
            return ('PhD [%(key)s]\n' + 
                    'TI "%(title)s"\n' + 
                    'AU %(author)s\n' + 
                    'IN In %(school)s, %(year)s') % self

        elif self['bibtype'].lower() == 'book':
            return ('Book [%(key)s]\n' +
                    'TI "%(title)s"\n' + 
                    'AU %(author)s\n' + 
                    'IN %(publisher)s, %(year)s') % self

        else:
            s = '%(bibtype)s [%(key)s]\n' % self
            if self['title']:
                s += 'TI "%(title)s"\n' % self
            if self['author']:
                s += 'AU %(author)s\n' % self
            for k, v in self.iteritems():
                if k not in ['title', 'author', 'bibtype', 'key', 'id', 'file', 'body', 'bodytext']:
                    s += 'MI %s: %s\n' % (k, v)

            return s.rstrip()

    def satisfies(self, filters):
        for field, regexp in filters:
            if not re.search(regexp, self[field], re.I):
                return False

        return True

class BibFile:

    def __init__(self, filelist=''):
        self.bibentries = []
        self.filters = []
        self.macros = {}
        self.sortfields = []
        if filelist:
            for f in filelist.splitlines():
                self.addfile(f)

    def addfile(self, file):
        fields = open(file).read().split('@')
        for f in fields:
            if not (f and re.match('string', f, re.I)):
                continue

            b = Bibliography('@' + f)
            self.macros.update(b['macro'])

        for f in fields:
            if not f or re.match('string', f, re.I):
                continue

            b = Bibliography('@' + f, self.macros)
            if b:
                b['file'] = file
                b['id'] = len(self.bibentries)
                self.bibentries += [b]


    def addfilter(self, filterspec):
        self.filters += [filterspec.split()]

    def rmfilters(self):
        self.filters = []

    def __str__(self):
        s = ''
        for b in self.bibentries:
            if b['key'] and b.satisfies(self.filters):
                s += '%s\n\n' % b
        return s

    def addsortfield(self, field):
        self.sortfields += [field]

    def rmsortfields(self):
        self.sortfields = []

    def sort(self):
        def cmpfun(b1, b2):
            for f in self.sortfields:
                c = cmp(b1[f], b2[f])
                if c:
                    return c
            return 0
        self.bibentries.sort(cmp=cmpfun)

if __name__ == "__main__":
    import sys

    bf = BibFile(sys.argv[1])
    print bf
