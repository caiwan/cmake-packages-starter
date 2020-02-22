#include <sol/sol.hpp>

#include "sol2.h"

bool HelloSol2::HelloFromLua()
{
    sol::state lua;
    lua.new_usertype<Vars>("Vars", "boop", &Vars::boop);
    lua.script(
      "beep = Vars.new()\n"
      "beep.boop = 1");
    return lua.get<Vars>("beep").boop == 1;
}
