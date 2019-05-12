#pragma once 
#include<nlohmann/json.hpp>

using Json = nlohmann::json;

class JsonTest {
public:
	int helloJson();
private:
	Json json;
};