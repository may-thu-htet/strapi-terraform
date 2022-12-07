locals {

  availability_zones = length(data.aws_availability_zones.this.names) > var.no_of_availability_zones ? slice(data.aws_availability_zones.this.names, 0, var.no_of_availability_zones) : data.aws_availability_zones.this.names

  # services_per_az is for creating subnet properties for services(ec2, rds, etc) in each az
  # this will be used in subnets.tf to create public and private subnet

  # services_per_az = [{
  #   service,
  #   availability_zone,
  #   cidr
  # },...]
  services_per_az = distinct(flatten([
    for i, service in var.services : [
      for idx, az in local.availability_zones : {
        service           = service
        availability_zone = az
        cidr              = "10.0.${i + 1}${idx}.0/24"
      }
    ]
  ]))


  # creating private subnet info for route-table subnet association
  # subnet is private if service name DOES NOT INCLUDE the word "-pub" (eg. rds)
  private_subnets = [
    for subnet in aws_subnet.subnets :
    subnet if !(length(regexall("-pub-", subnet.tags.Name)) > 0)
  ]

  # creating public subnet info for route-table subnet association
  # subnet is public if service name INCLUDES the word "-pub" (eg. ec2-pub)
  public_subnets = [
    for subnet in aws_subnet.subnets :
    subnet if length(regexall("-pub-", subnet.tags.Name)) > 0
  ]
}
