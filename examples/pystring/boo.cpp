#include <pystring/pystring.h>
#include <string>
#include <iostream>

int main() {
    std::string foo ("foo");
    std::string foo2 = pystring::capitalize(foo);
    std::cout << "capitalize: " << foo << " -> " << foo2 << std::endl;
    return 0;
}
