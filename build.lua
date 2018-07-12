require("ctan-post")

-- curl is default
-- ctan_post_command="curl" 

ctan={}

ctan.pkg="minitoc"

ctan.version=[[2018/07/12]] --OK

ctan.summary=[[Produce a table of contents for each chapter, part or section]]

ctan.author=[[Jean-Pierre Drucbert and GitHub minitoc organisation]]

ctan.email='d.p.carlisle@gmail.com'

ctan.uploader=[[David Carlisle]]

ctan.ctanPath=[[/macros/latex/contrib/minitoc]]

-- multiple licences, as a table
ctan.license='lppl'

ctan.update=true

ctan.announcement=[[
Minor update to minitoc to correct \@ifundefined use.

Minitoc still looking for maintainer but sources now on githib where issues may be tracked.

https://github.com/minitoc/minitoc/issues
]]


ctan.repository=[[https://github.com/minitoc/minitoc]]
ctan.support=[[https://github.com/minitoc/minitoc/issues]]

ctan.note=[[
Updating now as the package is broken by latex 2018 release.
Classifying as LPPL "maintained" by github "minitoc organisation"
which currently is just David Carlisle but volunteers welcome...
]]


ctan.file="minitoc-upload.zip"

ctan_upload(ctan,false)


