io.input("/proc/meminfo")
A = io.read("*a")
local total = A:match("%d+", string.find(A, "MemTotal"))
local free = A:match("%d+", string.find(A, "MemFree"))
local avail = A:match("%d+", string.find(A, "MemAvailable"))
local percent = (free / avail) * 100
return {
	total = total,
	free = free,
	avail = avail,
	percent = string.format("Mem: %d%%", percent),
	-- free / avail .. "%",
}
