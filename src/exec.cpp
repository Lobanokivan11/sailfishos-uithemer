#include "exec.h"
#include <QProcess>

std::string exec(const char* cmd)
{
    FILE* pipe = popen(cmd, "r");
    if (!pipe) return "ERROR";
    char buffer[128];
    std::string result = "";
    while(!feof(pipe)) {
        if(fgets(buffer, 128, pipe) != NULL)
            result += buffer;
    }
    pclose(pipe);
    return result;
}

void system_async(const std::string& cmd, std::function<void()> callback)
{
  auto cmdlambda = [cmd, callback]() {
      QProcess::execute(QString::fromStdString(cmd));
      callback();
  };

  std::thread t(cmdlambda);
  t.join();
}
