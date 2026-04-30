// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

#include <Memory.hpp>

LPVOID memcpy(LPVOID dest, LPCVOID src, UINT64 n) {
    LPUCHAR d = (LPUCHAR)dest;
    LPCUCHAR s = (LPCUCHAR)src;
    for (UINT64 i = 0; i < n; ++i)
        d[i] = s[i];
    return dest;
}

LPVOID memmove(LPVOID dest, LPCVOID src, UINT64 n) {
    LPUCHAR d = (LPUCHAR)dest;
    LPCUCHAR s = (LPCUCHAR)src;
    if (d < s) {
        for (UINT64 i = 0; i < n; ++i)
            d[i] = s[i];
    } else {
        for (UINT64 i = n; i > 0; --i)
            d[i-1] = s[i-1];
    }
    return dest;
}

LPVOID memset(LPVOID dest, INT32 c, UINT64 n) {
    LPUCHAR d = (LPUCHAR)dest;
    for (UINT64 i = 0; i < n; ++i)
        d[i] = (UCHAR)c;
    return dest;
}

INT32 memcmp(LPCVOID s1, LPCVOID s2, UINT64 n) {
    LPCUCHAR a = (LPCUCHAR)s1;
    LPCUCHAR b = (LPCUCHAR)s2;
    for (UINT64 i = 0; i < n; ++i) {
        if (a[i] != b[i])
            return (INT32)(a[i] - b[i]);
    }
    return 0;
}
