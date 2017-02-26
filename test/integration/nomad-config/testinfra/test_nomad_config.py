def test_config_dir(File):
    file = File('/etc/nomad')
    assert file.is_directory
    assert file.user == 'root'


def test_config_file_exists_and_owner(File):
    file = File('/etc/nomad/nomad.hcl')
    assert file.is_file
    assert file.user == 'root'


def test_service_is_running_and_enabled(Service):
    nomad = Service('nomad')
    assert nomad.is_running
    assert nomad.is_enabled
