terraform {
  required_providers {
    elasticstack = {
      source  = "elastic/elasticstack"
      version = "~> 0.6.2"
    }
  }
  required_version = ">= 1.4.2"
}

provider "elasticstack" {
  elasticsearch {
    api_key   = ""
    endpoints = [""]
  }
}

resource "elasticstack_elasticsearch_index" "my_index" {
  name = "my-index"
  alias {
    name = "my_alias_1"
  }
  alias {
    name = "my_alias_2"
    filter = jsonencode({
      term = { "user.id" = "developer" }
    })
  }
  mappings = jsonencode({
    properties = {
      field1 = { type = "keyword" }
      field2 = { type = "text" }
      field3 = {
        properties = {
          inner_field1 = { type = "text", index = false }
          inner_field2 = { type = "integer", index = false }
        }
      }
    }
  })
  number_of_shards   = 1
  number_of_replicas = 2
  search_idle_after  = "20s"
  #   total_shards_per_node = 200
}
