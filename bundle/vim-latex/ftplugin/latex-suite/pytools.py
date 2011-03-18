import string, vim, re, os, glob
# catFile: assigns a local variable retval to the contents of a file {{{
def catFile(filename):
	try:
		file = open(filename)
		lines = ''.join(file.readlines())
		file.close()
	except:
		lines = ''

	# escape double quotes and backslashes before quoting the string so
	# everything passes throught.
	vim.command("""let retval = "%s" """ % re.sub(r'"|\\', r'\\\g<0>', lines))
	return lines

# }}}
# isPresentInFile: check if regexp is present in the file {{{
def isPresentInFile(regexp, filename):
	try:
		fp = open(filename)
		fcontents = string.join(fp.readlines(), '')
		fp.close()
		if re.search(regexp, fcontents):
			vim.command('let retval = 1')
			return 1
		else:
			vim.command('let retval = 0')
			return None
	except:
		vim.command('let retval = 0')
		return None

# }}}
# deleteFile: deletes a file if present {{{
#	If the file does not exist, check if its a filepattern rather than a
#	filename. If its a pattern, then deletes all files matching the
#	pattern.
def deleteFile(filepattern):
	if os.path.exists(filepattern):
		try:
			os.remove(filepattern)
		except:
			vim.command('let retval = -1')
	else:
		if glob.glob(filepattern):
			for filename in glob.glob(filepattern):
				os.remove(filename)
		else:
			vim.command('let retval = -1')

# }}}
# vim:fdm=marker:ff=unix:noet:ts=4:sw=4:nowrap
