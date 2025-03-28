using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using System.Interop;
using System.Text;

using static snappyc.snappyc;

namespace example;

static class Program
{
	const char8* src = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed a sapien elit. Vivamus nisi purus, vehicula at nunc eu, hendrerit euismod quam. Duis neque turpis, faucibus eu pharetra at, mollis vitae nunc. Phasellus euismod consectetur justo, in luctus ligula molestie at. Duis a orci bibendum, auctor diam quis, maximus mauris. Nunc faucibus turpis sit amet ex molestie, a tincidunt nibh volutpat. Morbi id ipsum in sapien commodo facilisis vulputate auctor erat. Nunc aliquet urna quis tempus porttitor. Etiam sed ipsum in tortor ultrices ornare.";

	static int Main(params String[] args)
	{
		let src_len = scope String(src).Length;

		uint compressed_len = 0;
		char8[1024] compressed_buf;
		char8[1024] decompressed_buf;

		snappy_env env = ?;

		snappy_init_env(&env);
		defer snappy_free_env(&env);

		snappy_compress(&env, src, (.)src_len, &compressed_buf, &compressed_len);
		Debug.WriteLine($"lipsum len: {src_len}");
		Debug.WriteLine($"compressed len: {compressed_len}");
		Debug.WriteLine($"compression ratio: {(float)src_len / compressed_len }");

		snappy_uncompress(&compressed_buf, compressed_len, &decompressed_buf);
		Debug.WriteLine($"decompressed: {StringView(&decompressed_buf)}");

		return 0;
	}
}