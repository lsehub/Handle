/* Automatically generated from Squeak on 7 February 2011 4:16:29 pm 
   by VMMaker 3.11.13
 */

#define VMMAKER_VERSION "3.11.13"

#define SQ_VI_BYTES_PER_WORD 4

#ifndef allocateMemoryMinimumImageFileHeaderSize
 /* Called by Interpreter>>allocateMemory:minimum:imageFile:headerSize: */
 #define allocateMemoryMinimumImageFileHeaderSize(heapSize, minimumMemory, fileStream, headerSize) \
    sqAllocateMemory(minimumMemory, heapSize)
#endif

#ifndef sqImageFileReadEntireImage
 /* Called by Interpreter>>sqImage:read:size:length: */
 #define sqImageFileReadEntireImage(memoryAddress, elementSize,  length, fileStream) \
    sqImageFileRead(memoryAddress, elementSize,  length, fileStream)
#endif

