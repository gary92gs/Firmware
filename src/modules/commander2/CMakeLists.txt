############################################################################
#
#   Copyright (c) 2018 PX4 Development Team. All rights reserved.
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

include(common/smc)

px4_add_git_submodule(TARGET git_smc PATH ${PX4_SOURCE_DIR}/Tools/smc)

px4_state_machine_compiler(STATE_MACHINE MainStateMachine)

px4_add_module(
	MODULE modules__commander2
	MAIN commander2
	STACK_MAIN 4096
	STACK_MAX 2450
	INCLUDES
		${PX4_SOURCE_DIR}/Tools/smc/lib/C++
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}
	COMPILE_FLAGS
	SRCS
		Commander.cpp
		MainStateMachine.cpp
		${CMAKE_CURRENT_BINARY_DIR}/MainStateMachine_sm.cpp
		${CMAKE_CURRENT_BINARY_DIR}/MainStateMachine_sm.h
	DEPENDS
		generate_MainStateMachine
		generate_MainStateMachine_graph
		generate_MainStateMachine_table
	)
