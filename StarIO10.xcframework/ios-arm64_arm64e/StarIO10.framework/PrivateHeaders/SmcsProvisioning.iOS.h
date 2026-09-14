#pragma once

namespace StarPrntCommandUtil
{
namespace SmcsProvisioning
{
void getValue(int environment, int index, char *data, int size, int *outputSize);

void getPlatformTag(char *data, int size, int *outputSize);
} // namespace SmcsProvisioning
} // namespace StarPrntCommandUtil
