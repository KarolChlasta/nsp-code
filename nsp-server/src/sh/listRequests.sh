#!/bin/bash
# show list of mod from s3
#!/bin/bash
# show list of experiments from s3


for f in `aws s3 ls s3://nsp-project/models/genesis/| awk '{print $2}'| sed 's/\///g' `; do echo "$f"; done

