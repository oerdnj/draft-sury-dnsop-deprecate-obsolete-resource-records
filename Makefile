MMARK=${GOPATH}/bin/mmark

DRAFT=draft-sury-dnsop-deprecate-obsolete-resource-records

OUT= ${DRAFT}.xml ${DRAFT}.html ${DRAFT}.txt

all: ${OUT}

${DRAFT}.xml: ${DRAFT}.md
	${MMARK} ${DRAFT}.md >${DRAFT}.xml

${DRAFT}.html: ${DRAFT}.md
	xml2rfc --v3 --html -o ${DRAFT}.html ${DRAFT}.xml

${DRAFT}.txt: ${DRAFT}.xml
	xml2rfc --v3 --text ${DRAFT}.xml

commit: stamp ${OUT}
	git add ${OUT}
	git commit -m 'Update rendered versions'

stamp::
	./util/stamp ${DRAFT}.md

clean:
	rm -f ${OUT}
