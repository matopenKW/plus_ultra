provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "k8s_work" {
  name         = "k8s-work"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      size  = 20
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_ssh_key_path)}"
#    startup-script = file("${path.module}/scripts/startup.sh")
  }

  tags = [
    "k8s",
    "k8s-node",
  ]
}
