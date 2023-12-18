FROM naturalselect/x11pod:latest
LABEL "maintainer"="NaturalSelect<2145973003@qq.com>"
# Basic packages
RUN apt-get update && apt-get install wget -y

# Install java environment
RUN apt-get install -y openjdk-17-jdk maven

# Install eclipse
# RUN apt-get install eclipse -y
USER user
WORKDIR ${HOME}
RUN mvn org.apache.maven.plugins:maven-dependency-plugin:3.3.0:unpack -Dartifact=com.github.a-langer:org.eclipse.oomph.console.product:LATEST:tar.gz:linux.gtk.x86_64 -DoutputDirectory=./ -Dproject.basedir=./
RUN eclipse-installer/eclipse-inst -nosplash -application org.eclipse.oomph.console.application -vmargs \
  -Doomph.installation.location="${HOME}/eclipse-ide" \
  -Doomph.product.id="epp.package.java"
ENTRYPOINT [ "./eclipse-ide/eclipse/eclipse" ]
