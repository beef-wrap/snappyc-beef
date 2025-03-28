/*
 * C port of the snappy compressor from Google.
 * This is a very fast compressor with comparable compression to lzo.
 * Works best on 64bit little-endian, but should be good on others too.
 * Ported by Andi Kleen.
 * Uptodate with snappy 1.1.0
 */

/*
 * Copyright 2005 Google Inc. All Rights Reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 *     * Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above
 * copyright notice, this list of conditions and the following disclaimer
 * in the documentation and/or other materials provided with the
 * distribution.
 *     * Neither the name of Google Inc. nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
 
using System;
using System.Interop;

namespace snappyc;

public static class snappyc
{
    typealias size_t = uint;
    typealias char = c_char;

    /* Only needed for compression. This preallocates the worst case */
    [CRepr]
    public struct snappy_env {
        c_ushort *hash_table;
        void *scratch;
        void *scratch_output;
    }

    public struct iovec;

    [CLink] public static extern int snappy_init_env(snappy_env *env);
    [CLink] public static extern int snappy_init_env_sg(snappy_env *env, bool sg);
    [CLink] public static extern void snappy_free_env(snappy_env *env);
    [CLink] public static extern int snappy_uncompress_iov(iovec *iov_in, int iov_in_len, size_t input_len, char *uncompressed);
    [CLink] public static extern int snappy_uncompress(char *compressed, size_t n, char *uncompressed);
    [CLink] public static extern int snappy_compress(snappy_env *env, char *input, size_t input_length, char *compressed, size_t *compressed_length);
    [CLink] public static extern int snappy_compress_iov(snappy_env *env, iovec *iov_in, int iov_in_len, size_t input_length, iovec *iov_out, int *iov_out_len, size_t *compressed_length);
    [CLink] public static extern bool snappy_uncompressed_length(char *buf, size_t len, size_t *result);
    [CLink] public static extern size_t snappy_max_compressed_length(size_t source_len);
}