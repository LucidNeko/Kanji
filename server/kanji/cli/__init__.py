import click

@click.group(invoke_without_command=False)
def cli() -> None:
    """Kanji Server"""
    pass

@cli.command()
def debug() -> None:
    """Run development server"""

    from ..web import app

    app.run(
        debug=True,
        threaded=True,
        host='0.0.0.0',
        port=80,
    )
