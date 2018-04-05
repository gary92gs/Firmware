############################################################################
#
# Copyright (c) 2017 PX4 Development Team. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in
#    the documentation and/or other materials provided with the
#    distribution.
# 3. Neither the name PX4 nor the names of its contributors may be
#    used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
# OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
# AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
############################################################################

#=============================================================================
#
#	Defined functions in this file
#
# 	utility functions
#
#		* px4_generate_state_machine
#

include(CMakeParseArguments)
include(common/px4_base)

#=============================================================================
#
#	px4_state_machine_compiler
#
#	state machine compiler
#
#	Usage:
#		px4_state_machine_compiler()
#
#	Input:
#		XML : the airframes.xml file
#		BOARD : the board
#
#	Output:
#		OUT	: the generated source files
#
#	Example:
#		px4_state_machine_compiler()
#
function(px4_state_machine_compiler)
	px4_parse_function_args(
		NAME px4_state_machine_compiler
		ONE_VALUE STATE_MACHINE
		REQUIRED STATE_MACHINE
		ARGN ${ARGN})

	# MAIN STATE MACHINE
	add_custom_command(OUTPUT ${STATE_MACHINE}_sm.cpp ${STATE_MACHINE}_sm.h
		COMMAND
			java -jar ${PX4_SOURCE_DIR}/Tools/smc/bin/Smc.jar
				-nocatch -noex -c++ -crtp -cast static_cast -stack 10 -nostreams
				-d ${CMAKE_CURRENT_BINARY_DIR}
				${CMAKE_CURRENT_SOURCE_DIR}/${STATE_MACHINE}.sm
		DEPENDS
			${STATE_MACHINE}.sm
			git_smc
	)
	add_custom_target(generate_${STATE_MACHINE} DEPENDS ${STATE_MACHINE}_sm.cpp)

	add_custom_command(OUTPUT ${STATE_MACHINE}_sm.dot ${STATE_MACHINE}_sm.png
		COMMAND
			java -jar ${PX4_SOURCE_DIR}/Tools/smc/bin/Smc.jar
				-graph -glevel 1
				-d ${CMAKE_CURRENT_BINARY_DIR}
				${CMAKE_CURRENT_SOURCE_DIR}/${STATE_MACHINE}.sm
		COMMAND
			dot -T png -o ${STATE_MACHINE}_sm.png ${STATE_MACHINE}_sm.dot
		DEPENDS
			${STATE_MACHINE}.sm
			git_smc
	)
	add_custom_target(generate_${STATE_MACHINE}_graph DEPENDS ${STATE_MACHINE}_sm.dot)

	add_custom_command(OUTPUT ${STATE_MACHINE}_sm.html
		COMMAND
			java -jar ${PX4_SOURCE_DIR}/Tools/smc/bin/Smc.jar
				-table
				-d ${CMAKE_CURRENT_BINARY_DIR}
				${CMAKE_CURRENT_SOURCE_DIR}/${STATE_MACHINE}.sm
		DEPENDS
			${STATE_MACHINE}.sm
			git_smc
		USES_TERMINAL
	)
	add_custom_target(generate_${STATE_MACHINE}_table DEPENDS ${STATE_MACHINE}_sm.html)

endfunction()
