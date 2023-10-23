# Example of importing an existing resource into Terraform state, comment the following lines to avoid errors
resource "aws_instance" "app_server" {
    ami                                  = "ami-0136ddddd07f0584f"
    #arn                                  = ""
    associate_public_ip_address          = true
    availability_zone                    = "eu-west-1b"
    #cpu_core_count                       = 1
    #cpu_threads_per_core                 = 1
    disable_api_stop                     = false
    disable_api_termination              = false
    ebs_optimized                        = false
    get_password_data                    = false
    hibernation                          = false
    #id                                   = ""
    instance_initiated_shutdown_behavior = "stop"
    #instance_state                       = "running"
    instance_type                        = "t2.micro"
    #ipv6_address_count                   = 0
    #ipv6_addresses                       = []
    monitoring                           = false
    placement_partition_number           = 0
    #primary_network_interface_id         = ""
    #private_dns                          = ""
    private_ip                           = ""
    #public_dns                           = ""
    #public_ip                            = ""
    secondary_private_ips                = []
    security_groups                      = [
        "default",
    ]
    source_dest_check                    = true
    subnet_id                            = ""
    tags                                 = {
        "Name" = "CheckTerraform"
    }
    tags_all                             = {
        "Name" = "CheckTerraform"
    }
    tenancy                              = "default"
    vpc_security_group_ids               = [
        "",
    ]

    capacity_reservation_specification {
        capacity_reservation_preference = "open"
    }

    #cpu_options {
        #core_count       = 1
     #   threads_per_core = 1
    #}

    credit_specification {
        cpu_credits = "standard"
    }

    enclave_options {
        enabled = false
    }

    maintenance_options {
        auto_recovery = "default"
    }

    metadata_options {
        http_endpoint               = "enabled"
        http_put_response_hop_limit = 1
        http_tokens                 = "optional"
        instance_metadata_tags      = "disabled"
    }
    private_dns_name_options {
        enable_resource_name_dns_a_record    = false
        enable_resource_name_dns_aaaa_record = false
        hostname_type                        = "ip-name"
    }

    root_block_device {
        delete_on_termination = true
        #device_name           = "/dev/sda1"
        encrypted             = false
        iops                  = 100
        tags                  = {}
        throughput            = 0
        #volume_id             = ""
        volume_size           = 8
        volume_type           = "gp2"
    }
}
