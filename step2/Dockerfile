FROM julia:alpine

COPY src/ /opt/app/

RUN julia -e 'using Pkg;Pkg.add(["HTTP", "JSON"])'

EXPOSE 3000

CMD ["julia", "/opt/app/main.jl"]
