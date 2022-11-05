from pathlib import Path

DOIT_CONFIG = {'action_string_formatting': 'new'}

def task_convert():
    yield {
        'basename': 'do_pdf',
        'name': None,
        'doc': 'convert receptes/ to PDF',
        'watch': ['receptes'],
    }
    receptes = Path('receptes/')
    for p in receptes.glob('**/*.odt'):
        tmpFile = Path('/tmp') / p.stem
        t = Path('receptes-pdf') / p.relative_to(receptes).with_suffix(".pdf")
        yield {
            'basename': 'do_pdf',
            'name': str(p),
            'actions': [
                ['cp', '-f', p, tmpFile.with_suffix(".odt")],
                ['libreoffice', '--headless', '--convert-to', 'pdf', tmpFile.with_suffix(".odt"), '--outdir', tmpFile.parent ],
                ['mkdir', '-p', t.parent],
                ['mv', '-f', tmpFile.with_suffix(".pdf"), t],
            ],
            'file_dep': [p],
            'targets': [t],
        }

