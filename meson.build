project(
	'steamvr-openhmd', 'cpp',
	default_options : 'cpp_std=c++11',
	version : '0.0.1',
	meson_version:  '>=0.54'
)

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
