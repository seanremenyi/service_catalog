provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_servicecatalog_portfolio" "portfolio" {
  name          = "My App Portfolio"
  description   = "List of my organizations apps"
  provider_name = "Dev"
}

resource "aws_servicecatalog_product" "example" {
  name  = "example"
  owner = "Dev"
  type  = "CLOUD_FORMATION_TEMPLATE"

  provisioning_artifact_parameters {
    template_url = "https://amis-87h3r4fuh34uf34jf.s3.amazonaws.com/development-environment.template"
    type  = "CLOUD_FORMATION_TEMPLATE"
  }

  tags = {
    foo = "bar"
  }
}

resource "aws_servicecatalog_product_portfolio_association" "prodportassoci" {
  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = aws_servicecatalog_product.example.id
}

resource "aws_servicecatalog_principal_portfolio_association" "prodprincassoci" {
  portfolio_id  = aws_servicecatalog_portfolio.portfolio.id
  principal_arn = "arn:aws:iam::881437877674:user/Train"
}