function parseCsv( str ) {
  const lines = str.split( /\r?\n/ );
  let rows = [];

  for( let line of lines ) {
      line = line.trim();

      // skip empty & comment lines
      if( line.length === 0 || line.startsWith('#') ) {
         continue;
      }
      values = line.split(',');

      values = values.map( (val, index) => val.trim() );
      console.log( values );

      rows.push( values );
  }

  return rows
}


class Spritesheet {
   constructor( img, names,
                tileWidth=24,
                tileHeight=24 ) {
     this.img   = img;
     this.names = this._build_names( names );
     this.tileWidth =  tileWidth;
     this.tileHeight = tileHeight;
   }
   static read( src, names,
                tileWidth=24,
                tileHeight=24 ) {
      let img = new Image();
      img.src = src;
      return new Spritesheet( img, names, tileWidth, tileHeight );
   }


   _build_names( str ) {
      // assume text records in comma-separated values (.csv)
      // e.g.
      //   0, Male 1
      //   1, Male 2
      //   ...
      //   11, Rosy Cheeks (m)

      const rows = parseCsv( str );
      let names = {};
      for( let row of rows ) {
         let id = parseInt( row[0] );

         // note: allow more than one name  (split by pipe e.g. |)
         //     Marc 2 | Marc Mid  |  Marc Medium
         let values = row[1].split('|');
         for( let name of values) {
            name = this._norm_name( name );
            names[ name ] = id;
         }
      }

      return names;
   }

  _norm_name( str ) {
    str = str.toLowerCase();
    str = str.replaceAll( /[ _-]/ig, '' );
    console.log( str );
    return str;
  }

  drawSprite( name, sel, zoom=1 ) {
    let el = (typeof sel === 'string') ?
                 document.querySelector( sel )
                :
              sel;

    let num =  this.names[ this._norm_name( name ) ];
    this._drawSprite( num, el, zoom );
  }

  _drawSprite( num, el, zoom=1 ) {

     let canvas = document.createElement( 'canvas' );

    canvas.width = this.tileWidth*zoom;
    canvas.height =this.tileHeight*zoom;

    console.log( "==> Spritesheet.drawSprite" );
    console.log( canvas.width, canvas.height );

    let cols = this.img.naturalWidth / this.tileHeight;
    let rows = this.img.naturalHeight / this.tileWidth;
    console.log( cols, rows );

    let dy = Math.floor( num / cols );
    let dx = num % cols;
    console.log( dx, dy );

    let cx = canvas.getContext( "2d" );
    cx.clearRect( 0, 0, this.tileWidth, this.tileHeight );
    cx.imageSmoothingEnabled = false;
    cx.drawImage( this.img,
                  // source rect
                  dx*this.tileWidth, dy*this.tileHeight, this.tileWidth, this.tileHeight,
                  // dest rect
                  0, 0, this.tileWidth*zoom, this.tileHeight*zoom );

    el.appendChild( canvas );
}

  draw( sel='span.sprite', zoom=1 ) {
    // note: use onload (async) callback to wait for (required) image download to complete
    this.img.onload = () => {
       console.log( "  image.onload callback " );
       let els = document.querySelectorAll( sel );
       // console.log( els );

       for( let el of Array.from( els ) ) {
         let name = el.dataset.name;
         console.log( name );

         this.drawSprite( name, el, zoom );
       }
       console.log( "done Spritesheet.draw()" );
      }
    }
}

