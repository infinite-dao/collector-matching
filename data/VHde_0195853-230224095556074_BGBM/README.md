This folder normally contains the data from GBIF's “Virtual Herbarium Germany” (https://doi.org/10.15468/dl.tued2e). Only the sample files are contained here.

# Notes on the Data Structures

The only way to get media or source URLs together with `occurrence.txt` is to connect `gbifID` in both of the files of:  `multimedia.txt` and `occurrence.txt`.

## multimedia.txt

Understand `multimedia.txt`:

```bash
# What columns do we have at all in `multimedia.txt`?
head multimedia.txt -n 1 | sed 's@\t@\n@g' | awk '{print NR " ~ " $1}'
    # 1 ~ gbifID
    # 2 ~ type
    # 3 ~ format
    # 4 ~ identifier
    # 5 ~ references
    # 6 ~ title
    # 7 ~ description
    # 8 ~ source
    # 9 ~ audience
    # 10 ~ created
    # 11 ~ creator
    # 12 ~ contributor
    # 13 ~ publisher
    # 14 ~ license
    # 15 ~ rightsHolder

awk --field-separator='\t'  'BEGIN{OFS="\t"} NR<6{ print  $1, $2, $4, $5 }' multimedia.txt | column --table --separator $'\t'
  # gbifID      type        identifier                                                           references
  # 1019439041              https://herbarium.bgbm.org/data/iiif/B100190877/manifest.json        https://iiif.bgbm.org/?manifest=https://herbarium.bgbm.org/object/B100190877/manifest.json
  # 1019439041  StillImage  https://image.bgbm.org/images/internal/HerbarThumbs/B100190877_1700  https://herbarium.bgbm.org/object/B100190877
  # 1019439046  StillImage  https://image.bgbm.org/images/internal/HerbarThumbs/B100190852_1700  https://herbarium.bgbm.org/object/B100190852
  # 1019439046              https://herbarium.bgbm.org/data/iiif/B100190852/manifest.json        https://iiif.bgbm.org/?manifest=https://herbarium.bgbm.org/object/B100190852/manifest.json
```

## occurrence.txt

Understand `occurrence.txt`.

We could take `occurrenceID` (68th) as a reference to have “somehow good” published data on the web (there seem 483987 entries with no occurrenceID that could be seen as “data have no public occurrenceID” yet)

```bash
# What columns do we have at all in `occurrence.txt`?
head occurrence.txt -n 1 | sed 's@\t@\n@g' | awk '{print NR " ~ " $1}'
    # 1 ~ gbifID
    # 2 ~ abstract
    # 3 ~ accessRights
    # 4 ~ accrualMethod
    # 5 ~ accrualPeriodicity
    # 6 ~ accrualPolicy
    # 7 ~ alternative
    # 8 ~ audience
    # 9 ~ available
    # 10 ~ bibliographicCitation
    # 11 ~ conformsTo
    # 12 ~ contributor
    # 13 ~ coverage
    # 14 ~ created
    # 15 ~ creator
    # 16 ~ date
    # 17 ~ dateAccepted
    # 18 ~ dateCopyrighted
    # 19 ~ dateSubmitted
    # 20 ~ description
    # 21 ~ educationLevel
    # 22 ~ extent
    # 23 ~ format
    # 24 ~ hasFormat
    # 25 ~ hasPart
    # 26 ~ hasVersion
    # 27 ~ identifier
    # 28 ~ instructionalMethod
    # 29 ~ isFormatOf
    # 30 ~ isPartOf
    # 31 ~ isReferencedBy
    # 32 ~ isReplacedBy
    # 33 ~ isRequiredBy
    # 34 ~ isVersionOf
    # 35 ~ issued
    # 36 ~ language
    # 37 ~ license
    # 38 ~ mediator
    # 39 ~ medium
    # 40 ~ modified
    # 41 ~ provenance
    # 42 ~ publisher
    # 43 ~ references
    # 44 ~ relation
    # 45 ~ replaces
    # 46 ~ requires
    # 47 ~ rights
    # 48 ~ rightsHolder
    # 49 ~ source
    # 50 ~ spatial
    # 51 ~ subject
    # 52 ~ tableOfContents
    # 53 ~ temporal
    # 54 ~ title
    # 55 ~ type
    # 56 ~ valid
    # 57 ~ institutionID
    # 58 ~ collectionID
    # 59 ~ datasetID
    # 60 ~ institutionCode
    # 61 ~ collectionCode
    # 62 ~ datasetName
    # 63 ~ ownerInstitutionCode
    # 64 ~ basisOfRecord
    # 65 ~ informationWithheld
    # 66 ~ dataGeneralizations
    # 67 ~ dynamicProperties
    # 68 ~ occurrenceID
    # 69 ~ catalogNumber
    # 70 ~ recordNumber
    # 71 ~ recordedBy
    # 72 ~ recordedByID
    # 73 ~ individualCount
    # 74 ~ organismQuantity
    # 75 ~ organismQuantityType
    # 76 ~ sex
    # 77 ~ lifeStage
    # 78 ~ reproductiveCondition
    # 79 ~ behavior
    # 80 ~ establishmentMeans
    # 81 ~ degreeOfEstablishment
    # 82 ~ pathway
    # 83 ~ georeferenceVerificationStatus
    # 84 ~ occurrenceStatus
    # 85 ~ preparations
    # 86 ~ disposition
    # 87 ~ associatedOccurrences
    # 88 ~ associatedReferences
    # 89 ~ associatedSequences
    # 90 ~ associatedTaxa
    # 91 ~ otherCatalogNumbers
    # 92 ~ occurrenceRemarks
    # 93 ~ organismID
    # 94 ~ organismName
    # 95 ~ organismScope
    # 96 ~ associatedOrganisms
    # 97 ~ previousIdentifications
    # 98 ~ organismRemarks
    # 99 ~ materialSampleID
    # 100 ~ eventID
    # 101 ~ parentEventID
    # 102 ~ fieldNumber
    # 103 ~ eventDate
    # 104 ~ eventTime
    # 105 ~ startDayOfYear
    # 106 ~ endDayOfYear
    # 107 ~ year
    # 108 ~ month
    # 109 ~ day
    # 110 ~ verbatimEventDate
    # 111 ~ habitat
    # 112 ~ samplingProtocol
    # 113 ~ sampleSizeValue
    # 114 ~ sampleSizeUnit
    # 115 ~ samplingEffort
    # 116 ~ fieldNotes
    # 117 ~ eventRemarks
    # 118 ~ locationID
    # 119 ~ higherGeographyID
    # 120 ~ higherGeography
    # 121 ~ continent
    # 122 ~ waterBody
    # 123 ~ islandGroup
    # 124 ~ island
    # 125 ~ countryCode
    # 126 ~ stateProvince
    # 127 ~ county
    # 128 ~ municipality
    # 129 ~ locality
    # 130 ~ verbatimLocality
    # 131 ~ verbatimElevation
    # 132 ~ verticalDatum
    # 133 ~ verbatimDepth
    # 134 ~ minimumDistanceAboveSurfaceInMeters
    # 135 ~ maximumDistanceAboveSurfaceInMeters
    # 136 ~ locationAccordingTo
    # 137 ~ locationRemarks
    # 138 ~ decimalLatitude
    # 139 ~ decimalLongitude
    # 140 ~ coordinateUncertaintyInMeters
    # 141 ~ coordinatePrecision
    # 142 ~ pointRadiusSpatialFit
    # 143 ~ verbatimCoordinateSystem
    # 144 ~ verbatimSRS
    # 145 ~ footprintWKT
    # 146 ~ footprintSRS
    # 147 ~ footprintSpatialFit
    # 148 ~ georeferencedBy
    # 149 ~ georeferencedDate
    # 150 ~ georeferenceProtocol
    # 151 ~ georeferenceSources
    # 152 ~ georeferenceRemarks
    # 153 ~ geologicalContextID
    # 154 ~ earliestEonOrLowestEonothem
    # 155 ~ latestEonOrHighestEonothem
    # 156 ~ earliestEraOrLowestErathem
    # 157 ~ latestEraOrHighestErathem
    # 158 ~ earliestPeriodOrLowestSystem
    # 159 ~ latestPeriodOrHighestSystem
    # 160 ~ earliestEpochOrLowestSeries
    # 161 ~ latestEpochOrHighestSeries
    # 162 ~ earliestAgeOrLowestStage
    # 163 ~ latestAgeOrHighestStage
    # 164 ~ lowestBiostratigraphicZone
    # 165 ~ highestBiostratigraphicZone
    # 166 ~ lithostratigraphicTerms
    # 167 ~ group
    # 168 ~ formation
    # 169 ~ member
    # 170 ~ bed
    # 171 ~ identificationID
    # 172 ~ verbatimIdentification
    # 173 ~ identificationQualifier
    # 174 ~ typeStatus
    # 175 ~ identifiedBy
    # 176 ~ identifiedByID
    # 177 ~ dateIdentified
    # 178 ~ identificationReferences
    # 179 ~ identificationVerificationStatus
    # 180 ~ identificationRemarks
    # 181 ~ taxonID
    # 182 ~ scientificNameID
    # 183 ~ acceptedNameUsageID
    # 184 ~ parentNameUsageID
    # 185 ~ originalNameUsageID
    # 186 ~ nameAccordingToID
    # 187 ~ namePublishedInID
    # 188 ~ taxonConceptID
    # 189 ~ scientificName
    # 190 ~ acceptedNameUsage
    # 191 ~ parentNameUsage
    # 192 ~ originalNameUsage
    # 193 ~ nameAccordingTo
    # 194 ~ namePublishedIn
    # 195 ~ namePublishedInYear
    # 196 ~ higherClassification
    # 197 ~ kingdom
    # 198 ~ phylum
    # 199 ~ class
    # 200 ~ order
    # 201 ~ family
    # 202 ~ subfamily
    # 203 ~ genus
    # 204 ~ genericName
    # 205 ~ subgenus
    # 206 ~ infragenericEpithet
    # 207 ~ specificEpithet
    # 208 ~ infraspecificEpithet
    # 209 ~ cultivarEpithet
    # 210 ~ taxonRank
    # 211 ~ verbatimTaxonRank
    # 212 ~ vernacularName
    # 213 ~ nomenclaturalCode
    # 214 ~ taxonomicStatus
    # 215 ~ nomenclaturalStatus
    # 216 ~ taxonRemarks
    # 217 ~ datasetKey
    # 218 ~ publishingCountry
    # 219 ~ lastInterpreted
    # 220 ~ elevation
    # 221 ~ elevationAccuracy
    # 222 ~ depth
    # 223 ~ depthAccuracy
    # 224 ~ distanceAboveSurface
    # 225 ~ distanceAboveSurfaceAccuracy
    # 226 ~ distanceFromCentroidInMeters
    # 227 ~ issue
    # 228 ~ mediaType
    # 229 ~ hasCoordinate
    # 230 ~ hasGeospatialIssues
    # 231 ~ taxonKey
    # 232 ~ acceptedTaxonKey
    # 233 ~ kingdomKey
    # 234 ~ phylumKey
    # 235 ~ classKey
    # 236 ~ orderKey
    # 237 ~ familyKey
    # 238 ~ genusKey
    # 239 ~ subgenusKey
    # 240 ~ speciesKey
    # 241 ~ species
    # 242 ~ acceptedScientificName
    # 243 ~ verbatimScientificName
    # 244 ~ typifiedName
    # 245 ~ protocol
    # 246 ~ lastParsed
    # 247 ~ lastCrawled
    # 248 ~ repatriated
    # 249 ~ relativeOrganismQuantity
    # 250 ~ level0Gid
    # 251 ~ level0Name
    # 252 ~ level1Gid
    # 253 ~ level1Name
    # 254 ~ level2Gid
    # 255 ~ level2Name
    # 256 ~ level3Gid
    # 257 ~ level3Name
    # 258 ~ iucnRedListCategory
    # 259 ~ eventType


# What columns is recordedBy?
head occurrence.txt -n 1 | sed 's@\t@\n@g' | awk '{print NR " ~ " $1}' | grep --ignore-case recordedBy
# 71 ~ recordedBy
# 72 ~ recordedByID

# What columns is occurrenceID?
head occurrence.txt -n 1 | sed 's@\t@\n@g' | awk '{print NR " ~ " $1}' | grep --ignore-case occurrenceID
# 68 ~ occurrenceID
```

Get a glimps of data rows …

```bash
# Get a glimps of first rows of data including the header
awk --field-separator='\t'  'BEGIN{OFS="\t"} NR<11 { print $71, $72, $68 }' | column --table --separator $'\t'

# We could take occurrenceID as a reference to have published data on the web; there seem 483987 entries with no occurrenceID
awk --field-separator='\t'  'BEGIN{OFS="\t"} NR>1{ print $68 }' occurrence.txt | sort | uniq --count > occurrence-occurrenceID-count.txt
      head --lines=5 occurrence-occurrenceID-count.txt && tail --lines=5  occurrence-occurrenceID-count.txt
    #  483987 
    #       1 http://id.snsb.info/snsb/collection/108223/167001/109289
    #       1 http://id.snsb.info/snsb/collection/108224/167002/109290
    #       1 http://id.snsb.info/snsb/collection/108225/167003/109291
    #       1 http://id.snsb.info/snsb/collection/108226/167004/109292
    #       1 https://je.jacq.org/JEJE00029905
    #       1 https://je.jacq.org/JEJE00029906
    #       1 https://je.jacq.org/JEJE00029907
    #       1 https://je.jacq.org/JEJE00029955
    #       1 https://je.jacq.org/JEJE00029956

# Get some data rows containing an occurrenceID (no empty occurrenceID)
awk --field-separator='\t'  'BEGIN{OFS="\t"; n_occ=0} { 
  if(NR==1) { print $68, $71 } 
    if (match($68, /^http/)) { n_occ++ 
      if (n_occ < 11) { print $68, $71 }
    }
  } ' occurrence.txt | column --table --separator $'\t'
  
  # occurrenceID                    recordedBy
  # https://je.jacq.org/JE00003434  Ecklon,C.F. & Zeyher,C.L.P.
  # https://je.jacq.org/JE00003433  Ecklon,C.F. & Zeyher,C.L.P.
  # https://je.jacq.org/JE00003435  Ecklon,C.F. & Zeyher,C.L.P.
  # https://je.jacq.org/JE00003436  Ecklon,C.F. & Zeyher,C.L.P.
  # https://je.jacq.org/JE00003430  Zenker,G.
  # https://je.jacq.org/JE00003432  Ecklon,C.F. & Zeyher,C.L.P.
  # https://je.jacq.org/JE00003431  Zenker,G.
  # https://je.jacq.org/JE00015416  Reverchon,E.
  # https://je.jacq.org/JE00015417  Gaillardot,C.
  # https://je.jacq.org/JE00015418  Heldreich,T.H.H. von
  
# Are there data rows with recordedByID anywhere?
  # awk --field-separator='\t' '{print "recordedByID\t" $72 }' occurrence.txt | sort --unique > occurrence-recordedByID.txt # none
  awk --field-separator='\t'  'BEGIN{OFS="\t"; n_recId=0} { 
  if(NR==1) { print $68, $71, $72 } 
    if (match($72, /^.+/) && NR>1) { n_recId++ 
      if (n_recId < 11) { print $68, $71, $72 }
    }
  } ' occurrence.txt | column --table --separator $'\t'
  #  No: there is no recordedByID in the data
```

Write new data containing only occurrenceID as well:

```bash
# awk --field-separator='\t'  'BEGIN{OFS="\t"} NR>1{print $71 }' occurrence.txt | sort | uniq --count > occurrence-recordedBy-count.txt

awk --field-separator='\t'  'BEGIN{OFS="\t"; n_occ=0} { 
  if(NR==1) { print $68, $71 } 
  if (match($68, /^http/)) {  print $68, $71 }
  } ' occurrence.txt  > occurrence-recordedBy-having-occurrenceID.txt
  # cat occurrence-recordedBy-having-occurrenceID.txt | wc -l
  # 614641 minus 1 header line = 614640 records
```


