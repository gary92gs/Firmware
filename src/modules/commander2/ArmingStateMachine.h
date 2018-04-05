#pragma once

#include <uORB/topics/vehicle_status.h>
#include <uORB/topics/vehicle_status_flags.h>

#include <px4_defines.h>
#define TRACE PX4_INFO
#include "ArmingStateMachine_sm.h"

class ArmingStateMachine : public ArmingStateMachineContext<ArmingStateMachine>
{
private:

	vehicle_status_s	_vehicle_status{};
	vehicle_status_flags_s	_vehicle_status_flags{};

public:
	ArmingStateMachine();
	~ArmingStateMachine() {};

	const vehicle_status_s &status() { return _vehicle_status; }
	const vehicle_status_flags_s &status_flags() { return _vehicle_status_flags; }

	bool preflightCheck() { return true; }
	bool preArm() { return true; }

};
