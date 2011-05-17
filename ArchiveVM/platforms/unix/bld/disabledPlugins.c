/* this should be in a header file, but it isn't.  ho hum. */
typedef struct {
  char *pluginName;
  char *primitiveName;
  void *primitiveAddress;
} sqExport;
sqExport DBusPlugin_exports[] = { 0, 0, 0 };
sqExport GStreamerPlugin_exports[] = { 0, 0, 0 };
sqExport MIDIPlugin_exports[] = { 0, 0, 0 };
sqExport OggPlugin_exports[] = { 0, 0, 0 };
sqExport RomePlugin_exports[] = { 0, 0, 0 };
sqExport SqueakFFIPrims_exports[] = { 0, 0, 0 };
sqExport VideoForLinuxPlugin_exports[] = { 0, 0, 0 };
sqExport XDisplayControlPlugin_exports[] = { 0, 0, 0 };
sqExport vm_display_X11_exports[] = { 0, 0, 0 };
sqExport vm_display_custom_exports[] = { 0, 0, 0 };
sqExport vm_display_fbdev_exports[] = { 0, 0, 0 };
sqExport vm_sound_ALSA_exports[] = { 0, 0, 0 };
sqExport vm_sound_NAS_exports[] = { 0, 0, 0 };
sqExport vm_sound_OSS_exports[] = { 0, 0, 0 };
sqExport vm_sound_Sun_exports[] = { 0, 0, 0 };
sqExport vm_sound_custom_exports[] = { 0, 0, 0 };
