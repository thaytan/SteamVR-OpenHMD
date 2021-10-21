project(
	'steamvr-openhmd', 'cpp',
  default_options : ['cpp_std=c++11', 'buildtype=release'],
	version : '0.0.1',
	meson_version:  '>=0.54'
)

if host_machine.cpu_family() == 'x86'
  cpu_type='32'
elif host_machine.cpu_family() == 'x86_64'
  cpu_type='64'
else
  error('CPU family ' + host_machine.cpu_family() + ' is not supported')
endif

if host_machine.system() == 'linux'
  buildtype = 'linux' + cpu_type
  plugin_name='driver_openhmd.so'
elif host_machine.system() == 'windows'
  buildtype = 'win' + cpu_type
  plugin_name='driver_openhmd.dll'
else
  error('Target system ' + host_machine.system() + ' is not supported')
endif

sources = [
	'driverlog.cpp',
	'driverlog.h',
	'driver_openhmd.cpp'
]

includes = include_directories(['./subprojects/openvr'])

openhmd_subproject = subproject('openhmd', default_options: ['default_library=static'])

deps = [
	dependency('threads'),
	dependency('openhmd', fallback : ['openhmd', 'openhmd_dep'])
]

steamvr_openhmd_lib = library(
	'driver_openhmd', sources,
	include_directories : includes,
	dependencies : deps,
	install : true,
	version : meson.project_version(),
	name_prefix : ''
)

# This custom target copies the build results and required
# resources into the 'driver_openhmd' subdir ready to register
# with Steam
python = import('python').find_installation()

output_dir = 'driver_openhmd'

copy_script = '''
import sys, shutil, os
with open(sys.argv[1], 'w') as f:
    f.write('Installation dummy file')
source_dir = sys.argv[3]
output_dir = os.path.join(source_dir, sys.argv[4])
plugin_dest_dir = os.path.join(output_dir, sys.argv[5])
plugin_dest_file = os.path.join(plugin_dest_dir, sys.argv[6])

os.makedirs(plugin_dest_dir, exist_ok=True)
if os.path.exists(plugin_dest_file):
  os.remove(plugin_dest_file) # unlink dll first
shutil.copy(sys.argv[2], plugin_dest_file)
# Copy manifest and resources
shutil.copy(os.path.join(source_dir, 'driver.vrdrivermanifest'), os.path.join(output_dir, 'driver.vrdrivermanifest'))
shutil.copytree(os.path.join(source_dir, 'resources'), os.path.join(output_dir, 'resources'), dirs_exist_ok=True)
'''

custom_target('install-built-plugin',
  input: steamvr_openhmd_lib,
  output: 'installed.tstamp',
  command: [python, '-c', copy_script, '@OUTPUT@', '@INPUT@',
  meson.source_root(), output_dir, 'bin' / buildtype, plugin_name ],
  build_by_default: true)

#copyfiles = [
#	'driver.vrdrivermanifest',
#]
#foreach copyfile: copyfiles
#	configure_file(
#		input : copyfile,
#		output : copyfile,
#		configuration : configuration_data()
#	)
#endforeach
