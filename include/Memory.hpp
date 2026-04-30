// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

#ifndef _MEMFUNC_H
#define _MEMFUNC_H

#include <Types.hpp>

#ifdef __cplusplus
extern "C" {
#endif

LPVOID memcpy(LPVOID dest, LPCVOID src, UINT64 n);
LPVOID memmove(LPVOID dest, LPCVOID src, UINT64 n);
LPVOID memset(LPVOID dest, INT32 c, UINT64 n);
INT32   memcmp(LPCVOID s1, LPCVOID s2, UINT64 n);

#ifdef __cplusplus
}
#endif

#endif
