/// @description Destroy self if owner doesn't exist
if variable_instance_exists(self.id, "owner") {
	if !instance_exists(owner) {
		instance_destroy(self);
	}
}


