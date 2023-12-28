variable "ssh_key" {
  type = object({
    key_name   = string,
    public_key = string
  })
}