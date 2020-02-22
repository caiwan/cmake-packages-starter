#pragma once
#include <nlohmann/json.hpp>

using Json = nlohmann::json;

class JsonTest
{
public:
    int helloJson(const char string[17]);

private:
    Json json;
};
