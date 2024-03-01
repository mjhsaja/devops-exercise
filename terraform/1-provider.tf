# Init command
# gcloud config set project mashanz-software-engineering

# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = var.project_id
  region = var.region
  access_token = "ya29.c.c0AY_VpZhpX0WptnnLqw9OvAq-vyLm5H5Wq3AxvWYNTUxNDFUNmd_GJD0qFmjkOZbdxqMHt48vFkvH9GhShI2Kn6_e5pMUZ0OiVt3EkZul4arAsk0WvQQLYwNeJgLdBWUH9xMN_E8X1VMCStUO_RPFkVR3DHMDwG52ZX6U6Tx-JlCaoqMoGnnXxM2oaZh361tD-vQamJ_Sj2IXCK9kTyq90_mte-m06rt5FO5mzhSjaBq8gKu_bADxciRVC1kAEIeNZzaVffDTVLkt-fCREh1vUkIEs9MN85sM1MziWEKosuRh_DAXz7AhjpGk83JZPwiv96rtCBRSsIQcc49VjSuZn_u24WIOW5UwsO_AboDoQJcbWuHVaCLgbiKgbNSEujIR1dvhtKjl80cDhulMVSOdRfx19fRquNWzAEveQm9UGrhqtQcYD0OzsElPc-XCgofHlLEXIpl57lub0misMnMvdhkkWLlbvXyTJO0cZ0HoDUmoh-61Vm301IbxoftC0ktuzEOnuc62Fg4wdP0iEmVeYPjouzy5K4mXaH3EHtshltoestu9-rMz8MhK4A-N8ZX89zM2zNeEHhwrNHOOgFLU-bd9GJqxeWny77NWNVWYrqBnzmzPWhRUkWv_2VidG645DoRuZoIu-i2WcIme5OSygQwqt7kam_WMl4bm1hJf13RRsjooffWYBe_prXhaBp0Jo4F-gkgJwpn3IajO5pgMuWYZIWwdBVW2b-R__ZWji-Ugd3MnOawSg1tpQ6gc-u2g2-nnjtQzshcW2FJf0W8_7ynmdm1wnkRu4rJV7I91qJeg61_hlUh18FWqUouwQB16sdZdc1sb043FQSlF1Ozuhej7UwYROka9g_ZF_w8krBii9Ws5Mdb5nI5BqydblJ60aasR26qZyhg-6Bzi9i2nYf4i1d7IejbRZ2IZQlx35JF1swMqif_5lMwmmR5ohbtfXaoj9ZMf9Jm6JQvwvjkYuZdahwslb8QMgUW_Re5fM7oUaQ6WahUxuwd"
}

# https://terraform.io/language/settings/backends/gcs
terraform {
  backend "gcs" {
    bucket = "onxp-terraform"
    prefix = "terraform/state"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.14.0"
    }
  }
}