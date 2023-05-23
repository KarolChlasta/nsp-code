rm -rf ./nsp-model
git clone --recursive  https://karolchlasta@github.com/KarolChlasta/nsp-model.git
cd nsp-model
aws s3 cp . s3://nsp-project/models/genesis --recursive --exclude "*.md" --exclude ".*"

