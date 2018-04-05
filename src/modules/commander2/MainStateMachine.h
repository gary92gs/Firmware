#ifndef _H_THECONTEXT
#define _H_THECONTEXT

#include <uORB/topics/vehicle_status.h>
#include <uORB/topics/vehicle_status_flags.h>

#include "MainStateMachine_sm.h"

class MainStateMachine : public MainStateMachineContext<MainStateMachine>
{
private:

	bool isAcceptable;
	// If a string is acceptable, then this variable is set to YES;
	// NO, otherwise.

	vehicle_status_s	_vehicle_status{};
	vehicle_status_flags_s	_vehicle_status_flags{};

public:
	MainStateMachine();
	~MainStateMachine() {};

	inline void Acceptable() { isAcceptable = true; };
	inline void Unacceptable() { isAcceptable = false; };

	const vehicle_status_s &status() { return _vehicle_status; }
	const vehicle_status_flags_s &status_flags() { return _vehicle_status_flags; }

	void enterManual() {};


	void RejectRequest() {};
};

#endif
