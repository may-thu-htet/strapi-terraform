# strapi-terraform

Install Terraform👇

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform

/main.tf　にAWSプロフィールもしくはアクセスキーを記入
AWS名前付きプロフィールの方法👇

https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-profiles.html

/terraform.tfvars　にS3をアクセス出来るアクセスキーを記入

インフラのコンフィグ（ec2 instance type, rds instance type, ip制限など）は

/variables.tf　に変更

strapiのインストールscriptは　/modules/ec2/init/script.sh　に設定している。
詳しくは👇

https://docs.strapi.io/developer-docs/latest/setup-deployment-guides/deployment/hosting-guides/amazon-aws.html


Run 初期のみ：

`terraform init`

インフラ実行：

`terraform apply`

インフラ削除：

`terraform destroy`
