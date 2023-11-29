alias e = clear

def r [...paths: string] { e; lsd $paths }
def er [...paths: string] { e; lsd -l $paths }
def err [...paths: string] { e; lsd -lR $paths }
def et [...paths: string] { e; lsd --tree --depth=1 $paths }
def etr [...paths: string] { e; lsd --tree $paths }
