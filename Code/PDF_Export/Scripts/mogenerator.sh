#!/bin/sh

cd PDF_Export
if [ -f "/usr/bin/mogenerator" ]
then
    /usr/bin/mogenerator --template-var arc=true -m Resources/Models/PDF_Export.xcdatamodeld/PDF_Export.xcdatamodel/ -M Models/CoreData/Machine/ -H Models/CoreData/Human/
fi
