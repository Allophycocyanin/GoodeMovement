import sys
import pygame

from scripts.utility import load_image, load_images
from scripts.entities import PhysicsEntity
from scripts.tilemap import Tilemap

class Game:
    def __init__(self):
        pygame.init()

        pygame.display.set_caption('My Game')

        self.screen_width = 1280
        self.screen_height = 720
        self.screen = pygame.display.set_mode((self.screen_width, self.screen_height))

        self.clock = pygame.time.Clock()

        self.movement = {'left': False, 'right': False}

        self.assets = {
            'decor': load_images('tiles/decor'),
            'grass': load_images('tiles/grass'),
            'large_decor': load_images('tiles/large_decor'),
            'stone': load_images('tiles/stone'),
            
            'player': load_image('entities/test.png')
        }

        self.player = PhysicsEntity(self, 'player', (64, 0), (16, 16))

        self.tilemap = Tilemap(self, tile_size = 16)

    def run(self):
        while True:
            self.screen.fill((0, 0, 0))

            self.tilemap.render(self.screen)

            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    sys.exit()

                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_a or event.key == pygame.K_LEFT:
                        self.movement['left'] = True
                    if event.key == pygame.K_d or event.key == pygame.K_RIGHT:
                        self.movement['right'] = True
                    if event.key == pygame.K_SPACE:
                        self.player.velocity[1] = -1.5

                if event.type == pygame.KEYUP:
                    if event.key == pygame.K_a or event.key == pygame.K_LEFT:
                        self.movement['left'] = False
                    if event.key == pygame.K_d or event.key == pygame.K_RIGHT:
                        self.movement['right'] = False

            speed = 5
            total_movement = self.movement['right'] - self.movement['left']
            self.player.update(self.tilemap, (total_movement, 0), speed)
            self.player.render(self.screen)

            self.draw_grid()  # Call the draw_grid method

            pygame.display.update()
            self.clock.tick(60)

    def draw_grid(self):
        # Game Variables
        tile_size = 16  # pixels

        # Tile Size Guide
        for x in range(0, self.screen_width, tile_size):
            pygame.draw.line(self.screen, (255, 0, 0), (x, 0), (x, self.screen_height), 1)
        for y in range(0, self.screen_height, tile_size):
            pygame.draw.line(self.screen, (255, 0, 0), (0, y), (self.screen_width, y), 1)

Game().run()
