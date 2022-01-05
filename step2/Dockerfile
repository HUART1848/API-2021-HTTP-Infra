FROM julia:alpine

COPY src/ /opt/app/

RUN julia -e 'using Pkg;Pkg.add(["HTTP", "JSON"])'

CMD ["julia", "/opt/app/main.jl"]
