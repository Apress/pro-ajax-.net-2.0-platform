using System;
using System.Collections;
using System.Xml;


    /// <summary>
    /// Represents a collection of <see cref="Store">Store</see> objects.
    /// </summary>
    [Serializable]
    public class StoreCollection : CollectionBase
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="StoreCollection">StoreCollection</see> class.
        /// </summary>
        public StoreCollection()
        {
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="StoreCollection">StoreCollection</see> class containing the specified array of <see cref="Store">Store</see> Components.
        /// </summary>
        /// <param name="value">An array of <see cref="Store">Store</see> Components with which to initialize the collection. </param>
        public StoreCollection(Store[] value)
        {
            this.AddRange(value);
        }

        /// <summary>
        /// Gets the <see cref="Store">Store</see> at the specified index in the collection.
        /// <para>
        /// In C#, this property is the indexer for the <see cref="StoreCollection">StoreCollection</see> class.
        /// </para>
        /// </summary>
        public Store this[int index]
        {
            get { return ((Store)(this.List[index])); }
        }

        /// <summary>
        /// Add an instance of <see cref="Store">Store</see> to the <see cref="StoreCollection">StoreCollection</see>.
        /// </summary>
        /// <param name="value">An instance of <see cref="Store">Store</see>.</param>
        public int Add(Store value)
        {
            return this.List.Add(value);
        }

        /// <summary>
        /// Copies the elements of the specified <see cref="Store">Store</see> array to the end of the collection.
        /// </summary>
        /// <param name="value">An array of type <see cref="Store">Store</see> containing the Components to add to the collection.</param>
        public void AddRange(Store[] value)
        {
            for (int i = 0; (i < value.Length); i = (i + 1))
            {
                this.Add(value[i]);
            }
        }

        /// <summary>
        /// Adds the contents of another <see cref="StoreCollection">StoreCollection</see> to the end of the collection.
        /// </summary>
        /// <param name="value">A <see cref="StoreCollection">StoreCollection</see> containing the Components to add to the collection. </param>
        public void AddRange(StoreCollection value)
        {
            for (int i = 0; (i < value.Count); i = (i + 1))
            {
                this.Add((Store)value.List[i]);
            }
        }

        /// <summary>
        /// Gets a value indicating whether the collection contains the specified <see cref="Store">Store</see>.
        /// </summary>
        /// <param name="value">The <see cref="Store">Store</see> to search for in the collection.</param>
        /// <returns><b>true</b> if the collection contains the specified object; otherwise, <b>false</b>.</returns>
        public bool Contains(Store value)
        {
            return this.List.Contains(value);
        }

        /// <summary>
        /// Copies the collection Components to a one-dimensional <see cref="T:System.Array">Array</see> instance beginning at the specified index.
        /// </summary>
        /// <param name="array">The one-dimensional <see cref="T:System.Array">Array</see> that is the destination of the values copied from the collection.</param>
        /// <param name="index">The index of the array at which to begin inserting.</param>
        public void CopyTo(Store[] array, int index)
        {
            this.List.CopyTo(array, index);
        }

        /// <summary>
        /// Gets the index in the collection of the specified <see cref="Store">Store</see>, if it exists in the collection.
        /// </summary>
        /// <param name="value">The <see cref="Store">Store</see> to locate in the collection.</param>
        /// <returns>The index in the collection of the specified object, if found; otherwise, -1.</returns>
        public int IndexOf(Store value)
        {
            return this.List.IndexOf(value);
        }

        /// <summary>
        /// Inserts an instance of <see cref="Store">Store</see> into the <see cref="StoreCollection">StoreCollection</see> at the specified index.
        /// </summary>
        /// <param name="index">The index where the instance of <see cref="Store">Store</see> is to be inserted.</param>
        /// <param name="value">An instance of <see cref="Store">Store</see>.</param>
        public void Insert(int index, Store value)
        {
            List.Insert(index, value);
        }

        /// <summary>
        /// Removes an instance of <see cref="Store">Store</see> from the <see cref="StoreCollection">StoreCollection</see>.
        /// </summary>
        /// <param name="value">An instance of <see cref="Store">Store</see>.</param>
        public void Remove(Store value)
        {
            List.Remove(value);
        }

        /// <summary>
        /// Returns an enumerator that can iterate through the <see cref="StoreCollection">StoreCollection</see> instance.
        /// </summary>
        /// <returns>An <see cref="StoreEnumerator">StoreEnumerator</see> for the <see cref="StoreCollection">StoreCollection</see> instance.</returns>
        public new StoreEnumerator GetEnumerator()
        {
            return new StoreEnumerator(this);
        }

        /// <summary>
        /// Supports a simple iteration over a <see cref="StoreCollection">StoreCollection</see>.
        /// </summary>
        public class StoreEnumerator : IEnumerator
        {
            private IEnumerator _enumerator;
            private IEnumerable _temp;

            /// <summary>
            /// Initializes a new instance of the <see cref="StoreEnumerator">StoreEnumerator</see> class referencing the specified <see cref="StoreCollection">StoreCollection</see> object.
            /// </summary>
            /// <param name="mappings">The <see cref="StoreCollection">StoreCollection</see> to enumerate.</param>
            public StoreEnumerator(StoreCollection mappings)
            {
                _temp = ((IEnumerable)(mappings));
                _enumerator = _temp.GetEnumerator();
            }

            /// <summary>
            /// Gets the current element in the collection.
            /// </summary>
            public Store Current
            {
                get { return ((Store)(_enumerator.Current)); }
            }

            object IEnumerator.Current
            {
                get { return _enumerator.Current; }
            }

            /// <summary>
            /// Advances the enumerator to the next element of the collection.
            /// </summary>
            /// <returns><b>true</b> if the enumerator was successfully advanced to the next element; <b>false</b> if the enumerator has passed the end of the collection.</returns>
            public bool MoveNext()
            {
                return _enumerator.MoveNext();
            }

            bool IEnumerator.MoveNext()
            {
                return _enumerator.MoveNext();
            }

            /// <summary>
            /// Sets the enumerator to its initial position, which is before the first element in the collection.
            /// </summary>
            public void Reset()
            {
                _enumerator.Reset();
            }

            void IEnumerator.Reset()
            {
                _enumerator.Reset();
            }
        }
    }

