#! /bin/bash

set -x

in=$1
out=$(dirname $in)/$(basename $in .org).html
                        
ORGLETTER_HOME=${ORGLETTER_HOME:-$PWD}
ORGLETTER_TEMPLATES=${ORGLETTER_TEMPLATES:-$HOME/.org-letter}
                        
xml=$in.xml

org-to-xml.sh $in > $xml

template=$(xsltproc -o - --path $ORGLETTER_HOME/src write-letter-get-template.xsl $PWD/$in.xml)

if [[ -z "$template" ]]; then
    echo "warning: template not set in letter"
    template="templates/example1.html"
else
    #    echo "template: $template"
    :
fi

xsltproc --path . --path $ORGLETTER_HOME/templates --path $ORGLETTER_HOME/src --path $ORGLETTER_TEMPLATES -o $out --stringparam data-uri $PWD/$in.xml write-letter.xsl $template

rm $xml
