provider "scaleway" {
  access_key      = "<your_access_key>"
  secret_key      = "<your_secret_key>"
  organization_id = "<your_organization_id>"
  region          = "fr-par"
  zone            = "fr-par-1"
}

resource "scaleway_instance_server" "wordpresssrv" {
  name                = "gdg_meetup_terraform"
  tags                = [ "front", "web" ]
  type                = "DEV1-M"
  image               = data.scaleway_marketplace_image_beta.wordpress.id
  security_group_id   = scaleway_instance_security_group.www.id
  ip_id               = scaleway_instance_ip.public_ip.id
}

data "scaleway_marketplace_image_beta" "wordpress" {
  label  = "wordpress"
}

resource "scaleway_instance_security_group" "www" {
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port   = "22"
    ip     = "195.154.228.164"
  }

  inbound_rule {
    action = "accept"
    port   = "80"
  }

  inbound_rule {
    action = "accept"
    port   = "443"
  }
}

resource "scaleway_instance_ip" "public_ip" {}
