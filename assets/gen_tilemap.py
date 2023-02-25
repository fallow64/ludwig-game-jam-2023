from PIL import Image
import glob, os
from math import ceil, sqrt

tile_size = 32
tileset_size = 16
tileset_size_pixels = tileset_size * tile_size

tile_paths = list(filter(os.path.isfile, glob.glob("tiles/*.png")))
tile_paths.sort(key=lambda x: os.path.getmtime(x))

tileset = Image.new("RGBA", (tileset_size_pixels, tileset_size_pixels), (0, 0, 0, 0))

for tile_path, i in zip(tile_paths, range(len(tile_paths))):
    x = i % tileset_size
    y = i // tileset_size
    tile_image = Image.open(tile_path)

    if tile_image.size != (tile_size, tile_size):
        tile_image = tile_image.resize((tile_size, tile_size))
    
    tileset.paste(tile_image, (x * tile_size, y * tile_size))

tileset.save("tileset.png")