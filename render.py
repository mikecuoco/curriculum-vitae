#!/usr/bin/env python3
import sys
from pathlib import Path

import yaml
from jinja2 import Environment, FileSystemLoader, StrictUndefined


def load_yaml(path: Path):
    with path.open("r", encoding="utf-8") as f:
        return yaml.safe_load(f) or {}


def render_template(template_path: Path, data: dict, output_path: Path):
    env = Environment(
        loader=FileSystemLoader(str(template_path.parent)),
        autoescape=False,
        trim_blocks=True,
        lstrip_blocks=True,
        undefined=StrictUndefined,
        block_start_string="((*",
        block_end_string="*))",
        variable_start_string="((",
        variable_end_string="))",
        comment_start_string="((#",
        comment_end_string="#))",
    )

    template = env.get_template(template_path.name)
    output = template.render(**data)
    output_path.write_text(output, encoding="utf-8")


def main():
    repo_root = Path(__file__).parent
    template_path = repo_root / "main.tex.j2"
    data_path = repo_root / "cv.yaml"
    output_path = repo_root / "main.tex"

    if not template_path.exists():
        print(f"Template not found: {template_path}", file=sys.stderr)
        sys.exit(1)
    if not data_path.exists():
        print(f"Data file not found: {data_path}", file=sys.stderr)
        sys.exit(1)

    data = load_yaml(data_path)
    render_template(template_path, data, output_path)
    print(f"Rendered {output_path} from {template_path} and {data_path}")


if __name__ == "__main__":
    main()


