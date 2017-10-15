#ifndef EXEC_H
#define EXEC_H

#include <functional>
#include <string>
#include <iostream>
#include <stdio.h>
#include <future>
#include <thread>

std::string exec(const char *cmd);
void system_async(const std::string& cmd, std::function<void()> callback);

#endif // EXEC_H
