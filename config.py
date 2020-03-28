import multiprocessing
import math
# use at least one core more, for high-core machines, use 10% more
processes = int(math.ceil(multiprocessing.cpu_count() * 1.1))

global escape
from .observer import ProgressBarObserver

from cgi import escape
import os
import os.path

BASE = "/"

outputdir = BASE + "output"
worlds["Overworld"] = BASE + "/world/"

if not os.path.exists(outputdir):
    os.makedirs(outputdir)

def whitespace(s):
    return s.replace(' ', '&nbsp;')

def allSignFilter(poi):
    #print("=== POI ", poi, poi['id'])
    if poi['id'] == 'Sign' or poi['id'] == 'minecraft:sign':
        return "\n".join(map(escape, [poi['Text1'], poi['Text2'], poi['Text3'], poi['Text4']]))

def playerIcons(poi):
    if poi['id'] == 'Player':
        poi['icon'] = "http://overviewer.org/avatar/%s" % poi['EntityId']
        return "Last known location for %s" % poi['EntityId']

def spawnIcons(poi):
    if poi['id'] == 'PlayerSpawn':
        poi['icon'] = "http://overviewer.org/avatar/%s" % poi['EntityId']
        return "The current bed of %s" % poi['EntityId']

###

observer = ProgressBarObserver()

bounds = [(-3000, -3000, 0, 0), (0, 0, 3000, 3000)]

normal = "normal"
renders[normal] = {
    "world": "Overworld",
    "title": "Tag",
    #"rendermode": "lighting",
    "rendermode": "smooth_lighting",
    #"maxzoom": -2,
    "minzoom": 7,
    "defaultzoom": 10,

    #"imgformat": "webp",
    "imgformat": "jpg",
    "imgquality": "80",

    "markers": [dict(name="Schilder", filterFunction=allSignFilter),
                dict(name="Betten", filterFunction=spawnIcons),
                dict(name="Spieler", filterFunction=playerIcons)],
}

renders["night"] = {
    "world": "Overworld",
    "title": "Nacht",
    "rendermode": "smooth_night",
    #"maxzoom": -2,
    "minzoom": 7,
    "defaultzoom": 10,

    #"imgformat": "webp",
    "imgformat": "jpg",
    "imgquality": "80",

    'overlay': [normal]
}

"""
renders["rails"] = {
    'world': "Overworld",
    'rendermode': [#Base(),
        Hide(blocks=[x for x in range(0,1000) if x not in [27,28,66]]),
        MineralOverlay(
            minerals = [
                (27, (255, 0, 0)),
                (28, (255, 0, 0)),
                (66, (255, 0, 0))]
            ),
        EdgeLines()],
    "dimension": "overworld",
    'title': "Schnellbahnnetz",
    'overlay': [normal]
}
"""
