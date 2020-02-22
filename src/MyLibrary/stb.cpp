#include "stb.h"

// All the STB incluides w/ implementation definition
#define STB_DEFINE
#include <stb.h>

#define STB_C_LEXER_IMPLEMENTATION
#include <stb_c_lexer.h>
#define STBCC_GRID_COUNT_X_LOG2 10
#define STBCC_GRID_COUNT_Y_LOG2 10

#define STB_CONNECTED_COMPONENTS_IMPLEMENTATION
#include <stb_connected_components.h>

#define STB_DS_IMPLEMENTATION
#include <stb_ds.h>

#define STB_DXT_IMPLEMENTATION
#include <stb_dxt.h>
#include <stb_easy_font.h>

#define STB_HERRINGBONE_WANG_TILE_IMPLEMENTATION
#include <stb_herringbone_wang_tile.h>

#define STB_INCLUDE_IMPLEMENTATION
#include <stb_include.h>

#define STB_IMAGE_IMPLEMENTATION
#include <stb_image.h>

#define STB_IMAGE_RESIZE_IMPLEMENTATION
#include <stb_image_resize.h>

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include <stb_image_write.h>

#define STB_LEAKCHECK_IMPLEMENTATION
#include <stb_leakcheck.h>
// We'll substitude it with shaders
//#define STB_PERLIN_IMPLEMENTATION
//#include<stb_perlin.h>

#define STB_RECT_PACK_IMPLEMENTATION
#include <stb_rect_pack.h>

#define STB_SPRINTF_IMPLEMENTATION
#include <stb_sprintf.h>

// // Not really necessarry
// //#include<stb_tilemap_editor.h>
#define STB_TRUETYPE_IMPLEMENTATION
#include <stb_truetype.h>

// Not quiute portable ATM, tied to opengl :(
//#include<stb_voxel_render.h>
#include <stretchy_buffer.h>

int StbTest::Stb()
{
    // Lots of stuff goes around here
    return 0;
}
