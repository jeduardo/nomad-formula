def test_binary_created(File):
    file = File('/usr/bin/nomad')
    assert file.exists
    assert file.is_file
    assert file.user == 'root'
    assert file.group == 'root'
    assert oct(file.mode) == '0755'


def test_config_dir_created(File):
    file = File('/etc/nomad')
    assert file.exists
    assert file.is_directory
    assert file.user == 'root'
    assert file.group == 'root'
    assert oct(file.mode) == '0755'


def test_config_file_created(File):
    file = File('/etc/nomad/nomad.hcl')
    assert file.exists
    assert file.is_file
    assert file.user == 'root'
    assert file.group == 'root'
    assert oct(file.mode) == '0644'


def test_data_dir_created(File):
    file = File('/var/lib/nomad')
    assert file.exists
    assert file.is_directory
    assert file.user == 'root'
    assert file.group == 'root'
    assert oct(file.mode) == '0755'


def test_service_definition_created(File):
    file = File('/etc/systemd/system/nomad.service')
    assert file.exists
    assert file.is_file
