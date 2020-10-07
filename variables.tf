variable name {
  type = string
}

variable namespace {
  type = string
}

variable image {
  type = string
}

variable args {
  type = list(string)
}

variable restart_policy {
  type = string
  default = "Never"
}

variable annotations {
  type = map(string)
  default = {}
}

variable labels {
  type = map(string)
  default = {}
}

variable tolerations {
  type = list(object({ key = string, value = string }))
  default = []
}

variable node_selector {
  type = map(string)
  default = {}
}

variable env {
  type = map(string)
  default = {}
}

variable cpu {
  type = number
  default = 0.1
}

variable memory {
  type = number
  default = 128
}

variable env_from_secrets {
  type = set(string)
  default = []
}

variable wait_for_rollout {
  type = bool
  default = true
}

variable mount_host_paths {
  type = map(string)
  default = {}
}

variable init_containers {
  type = list(object({ args = list(string), env = map(string) }))
  default = []
}

variable mount_secrets {
  type = list(object({ secret = string, path = string, items = set(string) }))
  default = []
}

locals {
  mount_host_paths = {
    for key, value in var.mount_host_paths:
      "hosts-${sha256(key, 0, 4)}" => { host_path = key, mount_path = value }
  }

  mount_secrets = {
    for key, value in var.mount_secrets:
      "secret-${value.secret}" => value
  }
}
