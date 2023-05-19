resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "campaignId" = {
                "type" = "string"
            }
        },
        "type" = "object"
    })
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "divisionId" = {
                "type" = "string"
            }
        },
        "type" = "object"
    })
    
    config_request {
        request_template     = "$${input.rawRequest}"
        request_type         = "GET"
        request_url_template = "/api/v2/outbound/campaigns/$${input.campaignId}"
    }

    config_response {
        success_template = "{ \"divisionId\": $${divisionId} }"
        translation_map = { 
			divisionId = "$.division.id"
		}
        translation_map_defaults = {       
			divisionId = "\"\""
		}
    }
}